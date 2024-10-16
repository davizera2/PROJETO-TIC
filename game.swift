// Código feito em live // 

View().main()

class UserModel {
    var name: String = ""
    var favoriteGames: Array<GameModel> = []
}

class GameModel {
    var name: String

    init(_ name: String) {
        self.name = name
    }
}

enum Route {
    case home, options, gameList, addGames, gameSelect, deleteGameSelected, editGameSelected
}

class View {
    var viewModel: ViewModel = ViewModel()

    func main() {
        while true {
            switch viewModel.route {
            case .home:
                homeView()
            case .options:
                optionsView()
            case .gameList:
                gameListView()
            case .addGames:
                addGamesView()
            case .gameSelect:
                gameSelectView()
            case .deleteGameSelected:
                deleteGameSelectedView()
            case .editGameSelected:
                editGameSelectedView()
            }
        }
    }

    func homeView() {
        print("Para começar, informe seu nome: ")
        if !viewModel.setName() {
            print("Informe um nome válido")
        }
    }

    func optionsView() {
        print("Seja bem-vindo, \(viewModel.player.name)! O que você deseja fazer?")
        print("[A] Ver meus jogos")
        print("[B] Adicionar novos jogos")
        print("[C] Sair")

        if !viewModel.setOptions() {
            print("Informe um valor válido")
        }
    }

    func gameListView() {
        if viewModel.player.favoriteGames.isEmpty {
            print("Você ainda não adicionou nenhum jogo.")
        } else {
            print("Seus jogos favoritos:")
            for (index, game) in viewModel.player.favoriteGames.enumerated() {
                print("[\(index + 1)] \(game.name)")
            }
        }
        print("Você deseja selecionar algum jogo? (S/N)")

        if viewModel.isGameSelected() {
            viewModel.route = .gameSelect
        } else {
            viewModel.route = .options
        }
    }

    func addGamesView() {
        print("Nome do jogo:")
        if viewModel.setGame() {
            print("Jogo adicionado com sucesso")
        } else {
            print("Coloque um nome válido")
        }
    }

    func gameSelectView() {
        print("Escolha o jogo pelo número:")
        if viewModel.selectGame(), let game = viewModel.gameSelected {
            print("O que você deseja fazer com [\(game.name)]?")
            print("[A] Editar")
            print("[B] Deletar")
            print("[C] Sair")

            if !viewModel.selectOption() {
                print("Opção inválida")
            }
        } else {
            print("Selecione um jogo válido")
        }
    }

    func deleteGameSelectedView() {
        if viewModel.deleteSelectedGame() {
            print("Jogo deletado com sucesso.")
        } else {
            print("Erro ao deletar o jogo.")
        }
        viewModel.route = .options
    }

    func editGameSelectedView() {
        print("Digite o novo nome do jogo:")
        if viewModel.editSelectedGame() {
            print("Jogo editado com sucesso.")
        } else {
            print("Nome inválido.")
        }
        viewModel.route = .options
    }
}

class ViewModel {
    var route: Route = .home
    var player: UserModel = UserModel()
    var gameSelected: GameModel?
    var gameSelectedIndex: Int?

    func setName() -> Bool {
        guard let name = readLine(), !name.isEmpty else {
            return false
        }
        player.name = name
        route = .options
        return true
    }

    func setOptions() -> Bool {
        guard let option = readLine()?.uppercased() else { return false }
        switch option {
        case "A":
            route = .gameList
        case "B":
            route = .addGames
        case "C":
            print("Obrigado!")
            route = .home
        default:
            return false
        }
        return true
    }

    func selectGame() -> Bool {
        guard let select = readLine(), let index = Int(select),
              index > 0 && index <= player.favoriteGames.count else {
            return false
        }
        gameSelectedIndex = index - 1
        gameSelected = player.favoriteGames[gameSelectedIndex!]
        return true
    }

    func setGame() -> Bool {
        guard let gameName = readLine(), !gameName.isEmpty else {
            return false
        }
        player.favoriteGames.append(GameModel(gameName))
        route = .options
        return true
    }

    func isGameSelected() -> Bool {
        guard let option = readLine()?.uppercased(), option == "S" else {
            return false
        }
        return true
    }

    func selectOption() -> Bool {
        guard let option = readLine()?.uppercased() else { return false }
        switch option {
        case "A":
            route = .editGameSelected
        case "B":
            route = .deleteGameSelected
        case "C":
            route = .options
        default:
            return false
        }
        return true
    }

    func deleteSelectedGame() -> Bool {
        guard let index = gameSelectedIndex else { return false }
        player.favoriteGames.remove(at: index)
        gameSelected = nil
        gameSelectedIndex = nil
        return true
    }

    func editSelectedGame() -> Bool {
        guard let index = gameSelectedIndex, let newName = readLine(), !newName.isEmpty else {
            return false
        }
        player.favoriteGames[index].name = newName
        return true
    }
}
