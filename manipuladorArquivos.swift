import Foundation

func main() {
    print("Gerenciador de Arquivos de Texto")
    print("Escolha uma opção:")
    print("1. Contar palavras em um arquivo")
    print("2. Buscar uma palavra em um arquivo")
    print("3. import uma palavra em um arquivo")
    print("4. Sair")

    while true {
        print("Digite sua opção: ", terminator: "")
        guard let option = readLine(), let choice = Int(option) else {
            print("Opção inválida. Tente novamente.")
            continue
        }

        switch choice {
        case 1:
            contarPalavras()
        case 2:
            buscarPalavra()
        case 3:
            substituirPalavra()
        case 4:
            print("Saindo...")
            return
        default:
            print("Opção inválida. Tente novamente.")
        }
    }
}

func contarPalavras() {
    print("Digite o caminho do arquivo: ", terminator: "")
    guard let caminho = readLine() else {
        print("Caminho inválido.")
        return
    }

    do {
        let conteudo = try String(contentsOfFile: caminho, encoding: .utf8)
        let palavras = conteudo.split { $0.isWhitespace }
        print("Total de palavras: \(palavras.count)")
    } catch {
        print("Erro ao ler o arquivo: \(error.localizedDescription)")
    }
}

func buscarPalavra() {
    print("Digite o caminho do arquivo: ", terminator: "")
    guard let caminho = readLine() else {
        print("Caminho inválido.")
        return
    }

    print("Digite a palavra a ser buscada: ", terminator: "")
    guard let palavra = readLine() else {
        print("Palavra inválida.")
        return
    }

    do {
        let conteudo = try String(contentsOfFile: caminho, encoding: .utf8)
        let ocorrencias = conteudo.components(separatedBy: " ").filter { $0 == palavra }
        print("A palavra '\(palavra)' foi encontrada \(ocorrencias.count) vezes.")
    } catch {
        print("Erro ao ler o arquivo: \(error.localizedDescription)")
    }
}

func substituirPalavra() {
    print("Digite o caminho do arquivo: ", terminator: "")
    guard let caminho = readLine() else {
        print("Caminho inválido.")
        return
    }

    print("Digite a palavra a ser substituída: ", terminator: "")
    guard let palavraAntiga = readLine() else {
        print("Palavra inválida.")
        return
    }

    print("Digite a nova palavra: ", terminator: "")
    guard let palavraNova = readLine() else {
        print("Palavra inválida.")
        return
    }

    do {
        var conteudo = try String(contentsOfFile: caminho, encoding: .utf8)
        conteudo = conteudo.replacingOccurrences(of: palavraAntiga, with: palavraNova)
        try conteudo.write(toFile: caminho, atomically: true, encoding: .utf8)
        print("Substituição realizada com sucesso.")
    } catch {
        print("Erro ao processar o arquivo: \(error.localizedDescription)")
    }
}

// Inicia o programa
main()
