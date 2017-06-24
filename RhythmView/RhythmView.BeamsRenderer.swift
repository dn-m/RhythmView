//
//  RhythmView.BeamsRenderer.swift
//  RhythmView
//
//  Created by James Bean on 6/24/17.
//
//

import Collections
import ArithmeticTools
import RhythmSpellingTools
import GeometryTools
import PathTools
import GraphicsTools
import QuartzCore

extension RhythmView {
    
    class BeamsRenderer: Renderer {
        
        struct Configuration {
            let orientation: Orientation
            let slope: Double
            let width: Double
            let beamletLength: Double
            let displacement: Double
            let styling: Styling
        }
        
        /// Start and end values for each beam segment.
        private var beamSegments: [Int: [(Double, Double)]]
        
        /// Beamlet positions with direction.
        private var beamlets: [Int: [(Double, RhythmSpelling.BeamJunction.BeamletDirection)]]
        
        /// Previous x-values by level.
        private var start: [Int: Double]
        
        // MARK: - Initializers
        
        /// Creates a `BeamsRenderer` ready to receive commands in order to render beams.
        public init() {
            beamSegments = [:]
            beamlets = [:]
            start = [:]
        }
        
        /// Start a beam at the given horizontal position, on the given `level`.
        func startBeam(at x: Double, on level: Int) {
            start[level] = x
        }
        
        /// Stop the beam at the given horizontal position, on the given `level`.
        func stopBeam(at x: Double, on level: Int) {
            
            guard let start = self.start[level] else {
                fatalError()
            }
            
            beamSegments.safelyAppend((start,x), toArrayWith: level)
            self.start[level] = nil
        }
        
        func addBeamlet(
            at x: Double,
            on level: Int,
            direction: RhythmSpelling.BeamJunction.BeamletDirection
        )
        {
            beamlets.safelyAppend((x,direction), toArrayWith: level)
        }
        
        func render(in context: CALayer, with configuration: Configuration) {
            
            let view = BeamView(
                beams: makeBeams(configuration: configuration),
                styling: configuration.styling
            )
            
            context.addSublayer(CAShapeLayer(view.styledPath))
        }
        
        func makeBeams(configuration: Configuration) -> [Beam] {
            let beams = beamSegments.flatMap { level, beamSegments -> [Beam] in
                let displacement = Double(level - 1) * configuration.displacement
                return beamSegments.map { left, right in
                    let start = Point(x: left, y: left * configuration.slope + displacement)
                    let end = Point(x: right, y: right * configuration.slope + displacement)
                    return Beam(start: start, end: end, width: configuration.width)
                }
            }
            
            let beamlets = self.beamlets.flatMap { level, beamlets -> [Beam] in
                let displacement = Double(level - 1) * configuration.displacement
                return beamlets.map { x, direction in
                    let left = x
                    let right = x + (direction == .forward ? 1 : -1) * configuration.beamletLength
                    let start = Point(x: left, y: left * configuration.slope + displacement)
                    let end = Point(x: right, y: right * configuration.slope + displacement)
                    return Beam(start: start, end: end, width: configuration.width)
                }
            }
            
            return beams + beamlets
        }
    }
}
