import 'package:firebaseflutter/componentes/decoration_campo_auth.dart';
import 'package:firebaseflutter/services/authentication_servico.dart';
import 'package:flutter/material.dart';


class AutenticationTela extends StatefulWidget {
  const AutenticationTela({super.key});

  @override
  State<AutenticationTela> createState() => _AutenticationTelaState();
}

class _AutenticationTelaState extends State<AutenticationTela> {
  //variavel para checar se esta logado ou não
  bool isNotLogged = true;
  final _formKey = GlobalKey<FormState>();

  //controladores de texto
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();

  //instancia firebase
  AuthenticationServico _authServico = AuthenticationServico();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 85, 255),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,colors:[Color.fromARGB(255, 125, 196, 255),Color.fromARGB(255, 178, 116, 255),])
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key:_formKey, //chave "controladora"
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 18,),
                    TextFormField(controller:_emailController ,decoration: getAuthenticationInputDecoration("Email"),
                    validator: (String? value){
                      if(value == null){
                        return "O Email não pode ser vazio.";
                      }
                      if(value.length < 5){
                        return "O Email esta muito curto";
                      }
                      if(!value.contains('@')){
                        return "O Email não é valido.";
                      }
                      return null; //retorna nula caso não há problemas
                    },),
                    TextFormField(controller:_senhaController ,decoration: getAuthenticationInputDecoration("Senha"),validator: (String? value){
                      if(value == null){
                        return "A senha não pode ser vazia.";
                      }
                      if(value.length < 2){
                        return "A senha esta muito curta";
                      }
                      return null; //retorna nula caso não há problemas
                    },obscureText: true,),
                    Visibility(visible: !isNotLogged, child: Column(
                      children: [
                      TextFormField(decoration: getAuthenticationInputDecoration("Confirme a Senha"),obscureText: true,
                      validator: (String? value){
                      if(value == null){  
                        return "A Confirmação de senha não pode ser vazia.";
                      }
                      if(value.length < 2){
                        return "A senha esta muito curta";
                      }
                      return null; //retorna nula caso não há problemas
                    },),
                      TextFormField(controller:_nomeController ,decoration: getAuthenticationInputDecoration("Nome"),
                      validator: (String? value){
                      if(value == null){
                        return "O Nome não pode ser vazio.";
                      }
                      if(value.length < 1){
                        return "O Nome esta muito curto";
                      }
                      return null; //retorna nula caso não há problemas
                    },),
                      ],
                    )),
                    SizedBox(height: 18,),
                    ElevatedButton(onPressed: (){
                      botaoPrincipalClicado();
                    }, child: Text((isNotLogged)? "Entrar":"Cadastrar"),),
                    Divider(),
                    TextButton(onPressed: (){
                      setState(() {
                        isNotLogged = !isNotLogged;
                      });
                    }, child: Text((isNotLogged)?"Cadastrar":"Login"),),
                 ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
  //função botao
  botaoPrincipalClicado(){
    String email = _emailController.text;
    String senha = _senhaController.text;
    String nome = _nomeController.text;
    //valida todos campos que possuem validator, caso há um que não retorne nulo, não entra.
    if(_formKey.currentState!.validate()){
      if(isNotLogged){
        print("Entrada Validada");
      }else{
        print("Cadastro Validado");
        print("${_emailController.text},${_nomeController.text}");
        _authServico.cadastrarUsuario(nome: nome, senha: senha, email: email);
      }
    }else{
      print("Form Inválido");
    }
  }
}       
