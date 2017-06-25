//
//  RhythmViewTests.swift
//  RhythmView
//
//  Created by James Bean on 6/14/17.
//
//

import XCTest
import Collections
import Rhythm
import RhythmSpellingTools
import GeometryTools
import PathTools
import GraphicsTools
import RhythmView

class RhythmViewTests: XCTestCase {
    
    func testRender() {
        let durationTree = 4/>8 * [1,3,4,2,2,1]
        let contexts = durationTree.leaves.map { _ in MetricalContext<Int>.instance(.event(0)) }

        let rhythm = Rhythm(durationTree, contexts)
        let spelling = RhythmSpelling(rhythm)
        let spelledRhythm = SpelledRhythm(rhythm: rhythm, spelling: spelling)
        let rhythmView = RhythmView(spelledRhythm: spelledRhythm)
    
        let configuration = RhythmView.Configuration(
            beatWidth: 800,
            orientation: .stemsUp,
            slope: 0.25,
            beamWidth: 10,
            beamletLength: 10,
            beamDisplacement: 15,
            beamStyling: Styling()
        )
        
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 600, height: 600)
        rhythmView.render(in: layer, with: configuration)
        layer.renderToPDF(name: "beams")
    }
}
