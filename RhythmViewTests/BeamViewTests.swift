//
//  BeamViewTests.swift
//  RhythmView
//
//  Created by James Bean on 6/24/17.
//
//

import XCTest
import Collections
import ArithmeticTools
import Rhythm
import RhythmSpellingTools
import GeometryTools
import PathTools
import GraphicsTools
import RhythmView

class BeamViewTests: XCTestCase {
    
    func testInit() {
        
        let container = CALayer()
        let ΔY: Double = 40
        
        let beams: [Beam] = (0..<3).map { level in
            
            let y = Double(level) * ΔY
            let offsetLeft = 0.0
            let offsetRight = 20.0
            
            return Beam(
                start: Point(x: 0, y: y + offsetLeft),
                end: Point(x: 300, y: y + offsetRight),
                width: 30
            )
        }

        let beamView = BeamView(beams: beams, styling: Styling())
        let layer = CAShapeLayer(beamView.styledPath)
        layer.frame = CGRect(x: 0, y: 0, width: 300, height: 150)
        layer.renderToPDF(name: "beams")
    }
}
