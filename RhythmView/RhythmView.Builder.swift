//
//  RhythmView.Builder.swift
//  RhythmView
//
//  Created by James Bean on 6/24/17.
//
//

import RhythmSpellingTools

extension RhythmView {
    
    public static var builder: Builder {
        return Builder()
    }
    
    public final class Builder {
        
        @discardableResult func startBeam(onLevel: Int) -> Builder {
            return self
        }
        
        @discardableResult func endBeam(onLevel: Int) -> Builder {
            return self
        }
        
        @discardableResult func addBeamlet(
            onLevel: Int,
            direction: RhythmSpelling.BeamJunction.BeamletDirection
        ) -> Builder
        {
            return self
        }
    }
}
