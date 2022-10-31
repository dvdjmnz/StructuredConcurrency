//
//  DetailViewController+Sequential.swift
//  StructuredConcurrency
//
//  Created by David Jiménez Guinaldo on 30/10/22.
//

import Foundation

extension DetailViewController {
    func executeSequentialDefaultApproach() {
        let apiDataSource = FakeMusicApiDataSource()
        let artistId = "3"
        apiDataSource.getFirstAlbumIdForArtist(artistId: artistId) { albumId in
            apiDataSource.getFirstSongIdForAlbum(albumId: albumId) { songId in
                apiDataSource.getDurationForSong(songId: songId) { duration in
                    print(duration)
                }
            }
        }
    }
    
    func executeSequentialStructuredApproach() {
        Task {
            let apiDataSource = FakeMusicApiDataSource()
            let artistId = "3"
            let albumId = await apiDataSource.getFirstAlbumIdForArtist(artistId: artistId)
            let songId = await apiDataSource.getFirstSongIdForAlbum(albumId: albumId)
            let duration = await apiDataSource.getDurationForSong(songId: songId)
            print(duration)
        }
    }
}
