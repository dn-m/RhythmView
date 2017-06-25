//
//  BeamView.swift
//  RhythmView
//
//  Created by James Bean on 6/24/17.
//
//

import GeometryTools
import PathTools
import GraphicsTools

public struct BeamView {
    
    public let styledPath: StyledPath
    
    public init(beam: Beam, styling: Styling) {
        self.styledPath = StyledPath(path: beam.path, styling: styling)
    }
    
    public init(beams: [Beam], styling: Styling) {
        let path = beams.map { $0.path }.sum
        self.styledPath = StyledPath(path: path, styling: styling)
    }
}
