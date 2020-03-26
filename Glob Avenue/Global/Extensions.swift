//
//  Extensions.swift
//  Glob Avenue
//
//  Created by Imran Malik on 08/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit
import AVFoundation

extension URL {

    var thumbnail: UIImage? {
        let asset = AVURLAsset(url: self)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        let timestamp = CMTime(seconds: 2, preferredTimescale: 60)
        if let imageRef = try? generator.copyCGImage(at: timestamp, actualTime: nil) {
            return UIImage(cgImage: imageRef)
        } else {
            return nil
        }
    }

}


private let decoder = JSONDecoder()

extension Decodable {
    static func decode(data: Data, dateFormatter: DateFormatter? = nil) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}

extension Encodable {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}
