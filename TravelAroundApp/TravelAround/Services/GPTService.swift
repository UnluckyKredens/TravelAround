//
//  GPTService.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/16/24.
//

import Foundation

class ChatGPTService: ObservableObject {
    @Published var responseText: String = ""
    
    private let apiKey = "KEY_TO_OPENAI_API"
    
    func fetchBestTravelOption(from: String, to: String, budget: String) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            responseText = "Invalid URL."
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "Jesteś asystentem podróży, twoim zadaniem jest znalezienie dostępnych atrakcji w \(to), i wyliczenie wszystkich kosztów podróży.Zmieść się w 1000 słów i postaraj się dać najwięcej atrakcji. Nie pisz zakończenia i rozpoczęcia wiadomości, tylko sam opis"],
                ["role": "user", "content": "Znajdź najlepszy plan podróży z \(from) do \(to) z maksymalnym budżetem \(budget) zł. Podaj nazwy atrakcji i koszt podróży w tabeli."]
            ],
            "max_tokens": 1000
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                }
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    DispatchQueue.main.async {
                        self.responseText = content.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.responseText = "Unexpected response format."
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.responseText = "Failed to parse response: \(error.localizedDescription)"
                }
            }

            print(String(data: data, encoding: .utf8) ?? "Invalid response data")
        }.resume()
    }
}
