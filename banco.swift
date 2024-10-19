class Banco {
  var nome: String = ""
  var cpf: String = ""
  var email: String = ""
  var saldo: Float

  init(nome: String, cpf: String, email: String, saldo: Float) {
      self.nome = nome
      self.cpf = cpf
      self.email = email
      self.saldo = saldo
  }

  func exibirDados() {
      print(" --- Dados do cliente --- \n")
      print("Nome: \(self.nome)")
      print("CPF: \(self.cpf)")
      print("Email: \(self.email)")
      print("Saldo: \(self.saldo)")
      print("-- --- --- --- --- --- --")
  }

  func sacar() {
      print("--- SAQUE ---")
      print("Saldo: R$ \(saldo)")
      print("Valor do saque: ", terminator: "")
      let valor = Float(readLine() ?? "") ?? 0.0
      if (valor <= self.saldo) {
          self.saldo -= valor
      } else {
          print("Saldo insuficiente ... \n")
      }
  }

  func depositar() {
      print("--- DEPÓSITO ---")
      print("Saldo: R$ \(saldo)")
      print("Valor do depósito: ")
      let valor = Float(readLine() ?? "") ?? 0.0
      self.saldo += valor
      print("\n")
  }

  func verSaldo() {
      print("Saldo: R$ \(saldo)\n")
  }
}

func exibirMenu() -> Int {
  print("\n")
  print("""
  Bem-vindo ao Banco Terminal!
  Escolha uma opção:
  1. Criar Conta
  2. Ver Saldo
  3. Sacar
  4. Depositar
  5. Sair
  """)

  print("O que deseja? ", terminator: "")
  return Int(readLine() ?? "") ?? 0 
}

func iniciarBanco() {
  var cliente: Banco? = nil

  while true {
      let opcao = exibirMenu()

      switch opcao {
          case 1: 
            cliente = criarConta()
            print("Conta criada com sucesso!")
            break

          case 2:
            if let cliente = cliente {
                cliente.verSaldo()
            } else {
                print("Conta não encontrada! Por favor, crie uma conta.")
            }
            break
          
          case 3: 
            if let cliente = cliente {
                cliente.sacar()
            }
            break
          
          case 4:
            if let cliente = cliente {
                cliente.depositar()
            } else {
                print("Conta não encontrada! Por favor, crie uma conta.")
            }
            break
          case 5:
            print("Encerrando programa ... ")
            return
          default:
            print("Opção inválida! Tente novamente.")
      } 
  }
}
func criarConta() -> Banco{
  print("Digite seu nome: ", terminator:"")
  let nome = readLine() ?? ""

  print("CPF: ", terminator:"")
  let cpf = readLine() ?? ""

  print("Email: ", terminator:"")
  let email = readLine() ?? ""

  let saldo: Float = 1000.00
  print("Saldo inicial: R$ \(saldo)")

  return Banco(nome: nome, cpf: cpf, email: email, saldo: saldo)
}

iniciarBanco()
