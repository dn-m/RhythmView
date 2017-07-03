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

    func testRhythmView() {

        let durationTree = 4/>8 * [1,3,4,2,2,1]
        let contexts = durationTree.leaves.map { _ in MetricalContext<Int>.instance(.event(0)) }

        let rhythm = Rhythm(durationTree, contexts)
        let spelling = RhythmSpelling(rhythm)
        let spelledRhythm = SpelledRhythm(rhythm: rhythm, spelling: spelling)

        let beatWidth: Double = 480
        let positions = spelledRhythm.map { offset,_,_ in beatWidth * offset }

        let configuration = BeamsView.Configuration(
            orientation: .stemsDown,
            slope: 0.125,
            width: 4,
            beamletLength: 6,
            displacement: 6,
            color: .black
        )

        let beamsView = BeamsView(
            rhythmSpelling: spelledRhythm.spelling,
            positions: positions,
            configuration: configuration
        )

        let rhythmView = RhythmView(beamsView: beamsView)
        let path = rhythmView.rendered

        print(path)

        let layer = CALayer(path)
        layer.showTestBorder()
        layer.renderToPDF(name: "rhythm_view")
    }
}
