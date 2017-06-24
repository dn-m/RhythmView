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
    
    public init(start: Point, end: Point, height: Double) {
        
        let vertices = [
            start.translatedBy(x: 0, y: 0.5 * height),
            end.translatedBy(x: 0, y: 0.5 * height),
            end.translatedBy(x: 0, y: -0.5 * height),
            start.translatedBy(x: 0, y: -0.5 * height)
        ]
        
        let polygon = Polygon(vertices: vertices)
        self.path = Path(polygon)
    }
}
