//
//  Beam.swift
//  RhythmView
//
//  Created by James Bean on 6/24/17.
//
//

import GeometryTools
import PathTools

/// - TODO: Implement rotated sizing, rather than sheering
public struct Beam {
    
    public let path: Path
    
    public init(start: Point, end: Point, width: Double) {
        
        let vertices = [
            start.translatedBy(x: 0, y: 0.5 * width),
            end.translatedBy(x: 0, y: 0.5 * width),
            end.translatedBy(x: 0, y: -0.5 * width),
            start.translatedBy(x: 0, y: -0.5 * width)
        ]
        
        let polygon = Polygon(vertices: vertices)
        self.path = Path(polygon)
    }
}
