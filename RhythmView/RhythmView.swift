//
//  RhythmView.swift
//  RhythmView
//
//  Created by James Bean on 6/14/17.
//
//

import Collections
import Rhythm
import RhythmSpellingTools
import GraphicsTools
import QuartzCore

public class RhythmView: Renderer {
    
    public struct Configuration {
        
        // TODO: Create more rich structure
        public let beatWidth: Double
        public let orientation: Orientation
        public let slope: Double
        public let beamWidth: Double
        public let beamletLength: Double
        public let beamDisplacement: Double
        public let beamStyling: Styling
        
        public init(
            beatWidth: Double,
            orientation: Orientation,
            slope: Double,
            beamWidth: Double,
            beamletLength: Double,
            beamDisplacement: Double,
            beamStyling: Styling
        )
        {
            self.beatWidth = beatWidth
            self.orientation = orientation
            self.slope = slope
            self.beamWidth = beamWidth
            self.beamletLength = beamletLength
            self.beamDisplacement = beamDisplacement
            self.beamStyling = beamStyling
        }
    }
    
    private lazy var beamsRenderer: BeamsRenderer = {
        return BeamsRenderer()
    }()
    
    private let spelledRhythm: SpelledRhythm
    
    public init(spelledRhythm: SpelledRhythm) {
        self.spelledRhythm = spelledRhythm
    }
    
    public func render(in context: CALayer, with configuration: Configuration) {
        
        for (offset, leaf, item) in spelledRhythm {
            let x = offset * configuration.beatWidth
            prepareBeams(at: x, junction: item.beamJunction)
        }
        
        let beamsConfiguration = BeamsRenderer.Configuration(
            orientation: configuration.orientation,
            slope: configuration.slope,
            width: configuration.beamWidth,
            beamletLength: configuration.beamletLength,
            displacement: configuration.beamDisplacement,
            styling: configuration.beamStyling
        )
        
        beamsRenderer.render(in: context, with: beamsConfiguration)
    }
    
    private func prepareBeams(at x: Double, junction: RhythmSpelling.BeamJunction) {
        junction.states.forEach { level, state in
            switch state {
            case .start:
                beamsRenderer.startBeam(at: x, on: level)
            case .stop:
                beamsRenderer.stopBeam(at: x, on: level)
            case .beamlet(let direction):
                beamsRenderer.addBeamlet(at: x, on: level, direction: direction)
            default:
                break
            }
        }
    }
}
