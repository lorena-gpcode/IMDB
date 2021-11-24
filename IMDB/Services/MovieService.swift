//
//  MovieService.swift
//  IMDB
//
//  Created by Lorena Gama on 23/11/21.
//

import Foundation

protocol MovieService {
    
    func fetchMovies(from endpoint: MovieListEndpoint) async throws -> [Movie]
    func fetchMovie(id: Int) async throws -> Movie
    func searchMovie(query: String) async throws -> [Movie]
}

enum MovieListEndpoint: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
            case .nowPlaying: return "Recentes"
            case .upcoming: return "Próximos"
            case .topRated: return "+ Avaliados"
            case .popular: return "Populares"
        }
    }
}

enum MovieError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Desculpe, ocorreu uma falha em obter dados. Tente novamente depois!"
        case .invalidEndpoint: return "Desculpe, tivemos uma falha no nosso serviço. Tente novamente depois!"
        case .invalidResponse: return "Desculpe, nosso serviço está se comportando de forma inesperada. Tente novamente depois!"
        case .noData: return "Desculpe, houve um problema em obter os dados. Tente novamente depois!"
        case .serializationError: return "Desculpe, houve um problema no nosso serviço. Tente novamente depois!"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}

