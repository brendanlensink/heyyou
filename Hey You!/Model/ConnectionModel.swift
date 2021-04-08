//
//  ConnectionModel.swift
//  Hey You!
//
//  Created by Brendan on 2021-03-19.
//

import Bluejay
import Combine
import SwiftUI

class ConnectionModel: ObservableObject {
    @Published var connectionState = ConnectionState.searching
    @Published var danceColor: Color

    let colorSubject = PassthroughSubject<BTColor, Never>()
    let danceSubject = PassthroughSubject<Void, Never>()
    private var cancellables = [AnyCancellable]()

    private let bluejay = Bluejay()
    private var peripherals = [ScanDiscovery]() {
        didSet {
            if let first = peripherals.first {
                connectTo(first)
            }
        }
    }
    private var selectedPeripheralIdentifier: PeripheralIdentifier?

    init() {
        danceColor = Color("background")
        bluejay.start()

        startScanning()

        colorSubject.sink { [weak self] color in
            self?.writeColor(color)
            self?.danceColor = (color == SettingsModel.shared.defaultColor.btColor ? Color.black : color.color)
        }.store(in: &cancellables)

        danceSubject.sink { [weak self] in
            self?.startADanceParty()
        }.store(in: &cancellables)
    }

    private func startScanning() {
        bluejay.scan(
            // TODO: I'd really love to this by service rather than shitty name search :/
//            serviceIdentifiers: [
//                ServiceIdentifier(uuid: "FFD5"),
//                ServiceIdentifier(uuid: "FFD0")
//            ],
            duration: 15,
            allowDuplicates: false,
            serviceIdentifiers: nil,
            discovery: { [weak self ] discovery, discoveries in
                guard let weakSelf = self else {
                    return .stop
                }

                if discovery.peripheralIdentifier.name.contains("Triones") {
                    weakSelf.peripherals = [discovery]
                    return .stop
                }

                return .continue
            },
            stopped: { _, error in
                if let error = error {
                    print("scan stopped with error: \(error)")
                } else {
                    print("scan stopped without error")
                }
            }
        )
    }

    private func writeColor(_ color: BTColor) {
        writeColor(r: color.r, g: color.g, b: color.b)
    }

    private func writeColor(r: UInt8, g: UInt8, b: UInt8) {
        let data = Data([0x56, r, g, b, 0x00, 0xf0, 0xaa])
        let serviceID = ServiceIdentifier(uuid: "FFD5")
        let charID = CharacteristicIdentifier(uuid: "FFD9", service: serviceID)
        bluejay.write(to: charID, value: data, type: .withoutResponse) { result in
            print("=== SENT COLOR \(r) \(g) \(b)")
        }
    }

    private func connectTo(_ peripheral: ScanDiscovery) {
        let identifier = peripheral.peripheralIdentifier
        bluejay.connect(identifier, timeout: .none) { [weak self] result in
            switch result {
            case .success(let peripheral):
                debugPrint("Connection to \(peripheral) successful.")

                guard let weakSelf = self else {
                    return
                }
                weakSelf.selectedPeripheralIdentifier = identifier
                weakSelf.bluejay.stopScanning()
                weakSelf.connectionState = .connected

                weakSelf.writeColor(SettingsModel.shared.defaultColor.btColor)
            case .failure(let error):
                debugPrint("Connection to \(identifier) failed with error: \(error.localizedDescription)")
            }
        }
    }

    // Dance party nonsense
    private var tickCount = 0
    private var timer: Timer!
    private var previousColor: BTColor!
    private let danceColors = [BTColor.red, BTColor.yellow, BTColor.green, BTColor.orange, BTColor.pink, BTColor.purple]

    private func startADanceParty() {
        tickCount = 0
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(tick(_:)), userInfo: nil, repeats: true)
    }

    @objc private func tick(_ sender: Any) {
        guard tickCount < 10 else {
            writeColor(SettingsModel.shared.defaultColor.btColor)
            danceColor = .black
            timer.invalidate()
            return
        }

        let randomColor = danceColors.filter { $0 != previousColor }.randomElement()!
        writeColor(randomColor)
        danceColor = randomColor.color
        previousColor = randomColor
        tickCount += 1
    }

}
