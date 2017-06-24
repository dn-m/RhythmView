//
//  RhythmView.swift
//  RhythmView
//
//  Created by James Bean on 6/14/17.
//
//

import Collections
import ArithmeticTools
import Rhythm
import RhythmSpellingTools
import GeometryTools
import PathTools
import GraphicsTools
import QuartzCore

public struct RhythmView: Renderer {
    
    public struct Configuration {
        public let orientation: Orientation
        public let beamWidth: Double
        
        public init(orientation: Orientation, beamWidth: Double) {
            self.orientation = orientation
            self.beamWidth = beamWidth
        }
    }
    
    private let spelledRhythm: SpelledRhythm
    
    public init(spelledRhythm: SpelledRhythm) {
        self.spelledRhythm = spelledRhythm
    }
    
    public func render(in context: CALayer, with configuration: Configuration) {
        
        let beatWidth: Double = 240
        
        for offset in spelledRhythm.rhythm.metricalDurationTree.offsets {
            print("offset: \(offset.doubleValue * beatWidth)")
        }
        
        for item in spelledRhythm.spelling {
            print(item)
        }
        
        let rect = Path.rectangle(origin: Point(), size: Size(width: 100, height: configuration.beamWidth))
        let beam = CAShapeLayer(rect)
        beam.fillColor = Color.red.cgColor
        context.addSublayer(beam)
    }
}
