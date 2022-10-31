//
//  FakeMusicApiDataSource.swift
//  StructuredConcurrency
//
//  Created by David Jiménez Guinaldo on 30/10/22.
//

import Foundation

class FakeMusicApiDataSource {
    func getFirstAlbumIdForArtist(artistId: String, completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion("30")
        }
    }
    
    func getFirstSongIdForAlbum(albumId: String, completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion("20")
        }
    }
    
    func getDurationForSong(songId: String, completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion("214")
        }
    }
    
    func getFirstAlbumIdForArtist(artistId: String) async -> String {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                continuation.resume(with: .success("30"))
            }
        }
    }
    
    func getFirstSongIdForAlbum(albumId: String) async -> String {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                continuation.resume(with: .success("20"))
            }
        }
    }
    
    func getDurationForSong(songId: String) async -> String {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                continuation.resume(with: .success("214"))
            }
        }
    }
}
