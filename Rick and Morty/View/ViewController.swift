//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Евгений Глоба on 1/14/25.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        return table
    }()
    
    var isLoadingData = false
    var currentPage = 1
    let maxPages = 3
    var combinedDataSource: [(character: CharacterResult, episode: EpisodeResult)] = []
    
    //MARK: -View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadMoreData()
        
        NetworkMonitor.shared.startMonitoring()
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: .connectivityStatus, object: nil)
    }
    
    @objc func showOfflineDeviceUI(notification: Notification) {
        if NetworkMonitor.shared.isConnected {
            print("Connected to network")
        } else {
            print("Not connected to network")
            showAlert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Нет соединения", message: "Проверьте ваше интернет-соединение.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController?.present(alert, animated: true)
            }
        }
    }
    
    deinit { NotificationCenter.default.removeObserver(self, name: .connectivityStatus, object: nil) }
    
    private func setupTableView() {
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.frame = view.bounds
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    //MARK: -Load More Data
    private func loadMoreData() {
        guard !isLoadingData, currentPage <= maxPages else { return }
        
        isLoadingData = true
        
        Task {
            do {
                let characters = try await fetchCharacter(page: currentPage)
                let episodes = try await fetchEpisode(page: currentPage)
                
                let minCount = min(characters.count, episodes.count)
                let newItems = (0..<minCount).map { index in
                    (character: characters[index], episode: episodes[index])
                }
                
                combinedDataSource.append(contentsOf: newItems)
                currentPage += 1
                
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            } catch {
                print("Ошибка при загрузке данных для страницы \(currentPage): \(error)")
            }
            
            isLoadingData = false
        }
    }
    //MARK: - Fetch All Data
    private func fetchAllData(forPages pageRange: ClosedRange<Int>) async {
        combinedDataSource.removeAll()
        
        for page in pageRange {
            do {
                let characters = try await fetchCharacter(page: page)
                let episodes = try await fetchEpisode(page: page)
                
                let minCount = min(characters.count, episodes.count)
                
                combinedDataSource.append(contentsOf: (0..<minCount).map { index in
                    (character: characters[index], episode: episodes[index])
                })
            } catch {
                print("Ошибка при загрузке данных для страницы \(page): \(error)")
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    //MARK: -Fetch Character
    private func fetchCharacter(page: Int) async throws -> [CharacterResult] {
        do {
            return try await NetworkManager.fetchCharacters(page: page)
        } catch {
            print("Failed to fetch characters: \(error)")
            throw error
        }
    }
    //MARK: -Fetch Episode
    private func fetchEpisode(page: Int) async throws -> [EpisodeResult] {
        do {
            return try await NetworkManager.fetchEpisodes(page: page)
        } catch {
            print("Failed to fetch episodes: \(error)")
            throw error
        }
    }
}
    //MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return combinedDataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        let data = combinedDataSource[indexPath.row]
        cell.configure(with: data.character, andEpisode: data.episode)
        return cell
    }
}
    //MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedData = combinedDataSource[indexPath.row]
        
        let detailVC = DetailViewController()
        
        detailVC.character = selectedData.character
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == combinedDataSource.count - 1 { loadMoreData() }

        let inset: CGFloat = 10
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: inset / 2, left: inset, bottom: inset / 2, right: inset))
    }
}



