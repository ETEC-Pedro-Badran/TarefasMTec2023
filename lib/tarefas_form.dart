
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'tarefa_model.dart';
import 'tarefa_state.dart';
import 'tarefas_helper.dart';

class TarefasForm extends StatefulWidget {
  final TarefaState state;
  final TarefasHelper helper;
  const TarefasForm({super.key, required this.state, required this.helper});
  
  @override
  State<TarefasForm> createState() => _TarefasFormState();
}

class _TarefasFormState extends State<TarefasForm> {
  final _dateController = TextEditingController(); // controla o estado do campo da data

  final _formKey = GlobalKey<FormState>(); // 1- Controla o estado do formulário
  late Tarefa _tarefa;
  //05/10
  late DateFormat dateFormat; // declarando o atributo dateFormat
  @override
  void initState() {
    super.initState();
    _tarefa = widget.state.tarefa ?? Tarefa(descricao: "", prazo: DateTime.now()); 

     //05/10
    // inicializando o objeto dateFormat, responsável por formatar datas
    dateFormat = DateFormat("dd/MM/yyyy"); 
    if (_tarefa.prazo!=null) {
      atualizaPrazo(_tarefa.prazo);
    }
  }
  
   
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Form(
        
        key: _formKey, //2- relaciona o controlador de estado do formulário
        
        child: Column(
          children: [
            TextFormField(
              initialValue: _tarefa.descricao,
              decoration: const InputDecoration(
                  label: Text("Descrição"), border: OutlineInputBorder()),
              validator: (value) => (value??"").isEmpty?"Uma descrição para a tarefa deve ser informada.":null,  // 4- Validador do campo descrição
              onSaved: (value)=>_tarefa.descricao = value!, // 7- Recebendo o valor do campo e armazenando na propriedade do objeto que está recebendo os dados do formulário
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _dateController, // controlador associado
              readOnly: true,
              onTap: () async {
               var data = await showDatePicker(context: context,
               
               initialDate: DateTime.now(), 
               firstDate: DateTime.now(), 
               lastDate: DateTime.now().add(const Duration(days: 365)),);
                print(data);
                if (data!=null) {
                  atualizaPrazo(data);  //05/10
                  
                }
              } ,

              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                  label: Text("Prazo"), border: OutlineInputBorder()),
              validator: (value){
                /**5 - validando o campo do prazo */
                  try {
                    DateTime data = dateFormat.parse(value!); //05/10
                    if (data.isBefore(DateTime.now()))                  {
                       return "Data não pode ser no passado!";  
                    }
                  } catch(e){
                    return "Data inválida";
                  }
              },                                
              //05/10
              onSaved: (value) => _tarefa.prazo = dateFormat.parse(value!), // 8 - armazenando a data no campo prazo da tarefa 
            ),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () async {
              
              _formKey.currentState!.deactivate();
              //3- Executa a validação do formulário
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save(); // 4-Solicita ao formulário que salve os dados
                print("Tarefa digitada: $_tarefa");  // 9- Aqui iremos enviar para o banco de dados

                await widget.helper.salvar(_tarefa); 
                Navigator.of(context).pop(); // fecha a janela

              }
            }, child: const Text("Salvar"))
          ],
        ),
      ),
    );
  }
  
  //05/10
  void atualizaPrazo(data) {
    String dataFormatada = dateFormat.format(data);
    _dateController.text = dataFormatada;
  }
}
