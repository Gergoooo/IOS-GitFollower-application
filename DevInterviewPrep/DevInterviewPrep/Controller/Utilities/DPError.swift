//
//  ErrorMessage.swift
//  DevInterviewPrep
//
//  Created by Gergő  on 2025. 09. 18..
//

import Foundation

enum DPError: String, Error {
    
    case invalidUsername = "Invalid username"
    case unabelToComlplete = "Unable to complete your request. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recived from the server was invalid. Please try again."
    case unableToFavorite = "There was an error adding this user to the favorites. Please try again."
    case alreadyInFavorites = "This user is already added to your favorites."
}
