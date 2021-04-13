//
//  SearchTableViewController.swift
//  NBAStatsGo
//
//  Created by David Liu on 3/29/21.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    // Initialize API Manager
    let apiManager: APIManager = BallDontLieAPIManager()
    
    // Search Bar
    var playerSearchBar: UISearchBar?

    // NBA Players
    var players = [[Player]]()
    
    // Global Player List
    var allPlayers = [Player]()
    
    // Selected Player from table
    var selectedPlayer: Player?
    
    // How Search Table was called - default (tab bar is "Tab"), "Statlines", "Comparison"
    var source: String? = "Tab"

    override func viewDidLoad() {
        super.viewDidLoad()
        playerSearchBar = initSearchBar()
        DispatchQueue.global(qos: .utility).async {
            do {
                
                // TODO: start loading icon
                self.allPlayers = try self.apiManager.getPlayers(filters:["name": ""])
                self.transformData(transformingPlayers: self.allPlayers)
               
                DispatchQueue.main.async {
                    // TODO: stop loading icon
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
                Alert.alert(title: "Error Getting Players", message: error.localizedDescription, on: self)
            }
            
        }
    }
    
    // Prepare for various segue options including:
    // Going to individual player stats view (PlayerStatsViewController)
    // Unwind to statlines view (StatlinesViewController)
    // Unwind to comparison view (ComparisonViewController)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "viewPlayerStats" {
                let playerStatsViewController = segue.destination as! PlayerStatsViewController
                playerStatsViewController.currViewedPlayer = selectedPlayer
            } else if identifier == "statlinesSearch" {
                let statlinesViewController = segue.destination as! StatlinesViewController
                statlinesViewController.currStatlinesPlayer = selectedPlayer
            } else if identifier == "comparisonSearch" {
                let comparisonViewController = segue.destination as! ComparisonViewController
                if (source == "ComparisonOne") {
                    comparisonViewController.currCompareFirstPlayer = selectedPlayer
                } else if (source == "ComparisonTwo") {
                    comparisonViewController.currCompareSecondPlayer = selectedPlayer
                }
            }
        }
    }
    
    func transformData(transformingPlayers: [Player]) {
        var transformedPlayers = [[Player]]()
        var a_list = [Player](), b_list = [Player](), c_list = [Player](),
            d_list = [Player](), e_list = [Player](), f_list = [Player](),
            g_list = [Player](), h_list = [Player](), i_list = [Player](),
            j_list = [Player](), k_list = [Player](), l_list = [Player](),
            m_list = [Player](), n_list = [Player](), o_list = [Player](),
            p_list = [Player](), q_list = [Player](), r_list = [Player](),
            s_list = [Player](), t_list = [Player](), u_list = [Player](),
            v_list = [Player](), w_list = [Player](), x_list = [Player](),
            y_list = [Player](), z_list = [Player]()
        for player in transformingPlayers {
            // Handle case where player does not have last name
            let lastNameInitial = player.lastName.prefix(1).isEmpty ? "Z" : player.lastName.prefix(1)
            let lastNameInitialInt = Character(String(lastNameInitial)).asciiValue! - 65
            switch lastNameInitialInt {
            case 0:
                a_list.append(player)
            case 1:
                b_list.append(player)
            case 2:
                c_list.append(player)
            case 3:
                d_list.append(player)
            case 4:
                e_list.append(player)
            case 5:
                f_list.append(player)
            case 6:
                g_list.append(player)
            case 7:
                h_list.append(player)
            case 8:
                i_list.append(player)
            case 9:
                j_list.append(player)
            case 10:
                k_list.append(player)
            case 11:
                l_list.append(player)
            case 12:
                m_list.append(player)
            case 13:
                n_list.append(player)
            case 14:
                o_list.append(player)
            case 15:
                p_list.append(player)
            case 16:
                q_list.append(player)
            case 17:
                r_list.append(player)
            case 18:
                s_list.append(player)
            case 19:
                t_list.append(player)
            case 20:
                u_list.append(player)
            case 21:
                v_list.append(player)
            case 22:
                w_list.append(player)
            case 23:
                x_list.append(player)
            case 24:
                y_list.append(player)
            case 25:
                z_list.append(player)
            default:
                continue
            }
        }
        transformedPlayers.append(a_list)
        transformedPlayers.append(b_list)
        transformedPlayers.append(c_list)
        transformedPlayers.append(d_list)
        transformedPlayers.append(e_list)
        transformedPlayers.append(f_list)
        transformedPlayers.append(g_list)
        transformedPlayers.append(h_list)
        transformedPlayers.append(i_list)
        transformedPlayers.append(j_list)
        transformedPlayers.append(k_list)
        transformedPlayers.append(l_list)
        transformedPlayers.append(m_list)
        transformedPlayers.append(n_list)
        transformedPlayers.append(o_list)
        transformedPlayers.append(p_list)
        transformedPlayers.append(q_list)
        transformedPlayers.append(r_list)
        transformedPlayers.append(s_list)
        transformedPlayers.append(t_list)
        transformedPlayers.append(u_list)
        transformedPlayers.append(v_list)
        transformedPlayers.append(w_list)
        transformedPlayers.append(x_list)
        transformedPlayers.append(y_list)
        transformedPlayers.append(z_list)
        self.players = transformedPlayers
    }
}
