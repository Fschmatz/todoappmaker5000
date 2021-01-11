class versaoNomeChangelog{

  //se mudar o nome do App não esquecer de alterar, no manifesto
  static String versaoApp = "3.5e";
  static String nomeApp = "TodoAppMaker5000 Fschmtz";

  //1espaço acima, nenhum embaixo
  static String changelogUltimaVersao = '''  
  
Versão Atual:  
  
3.5
- Removido o FutureBuilder por questão de performance e Bugs
- Usando agora ListView.Builder + UniqueKey, para detectar mudanças na arvore dos Widgets
  ''';


  static String changelogsAntigos = '''

3.4
- Trocado CheckBoxListTile por ListTile
- Opção de Excluir Tarefa nas Completas 
- Correções

3.3
- Correções para todo lado

3.2b
- Home Builder 98%
- Bug Fix do Refresh()
- Página das Tarefas Completas
- Mudança de Estado da Tarefa

3.1
- IsDense e ThreeLine com Ternários
- Mudanças nos Espaçamentos
- Correções

3.0
- Home Builder 95% Todos com FutureBuilder
- Correção das listas
- Removido builder dos Cards Task
- Nome task com 30 chars
  
2.9
- Home Builder 90%
- Organizado os Refresh()
- Bug do nova categoria resolvido
  
2.8
- Home Builder 70%
- Novos DAOs
- Correções
  
2.7b
- Bug Fix List = [];
  
2.7
- Home Builder 40%
- Correções

2.6
- Salvar Task OK
- Correções

2.5
- Adicionados checks para todos os
  campos, maxLength bugado no Flutter
  enforçado através de length
- Correções

2.4
- Select categoria OK
- Correções
  
2.3
- Novos Dialogs
- Correções
- Novo Changelog

2.2 -> Mudanças DB + Testes
2.1 -> Checagem campos nulos OK
2.0 -> Salvar Listas e Tarefas OK
1.9c -> Correções 
1.9b -> Correções 
1.9 -> Salvando Categorias OK
1.8 -> Color Picker
1.7 -> Dialogs FullScreen
1.6 -> Dialogs Personalizados
1.5 -> Reorganizados DAOs
1.4 -> CriadorDb implementado
1.3 -> Database funcional
1.2 -> Database iniciado
1.1 -> Melhorias de Desempenho
1.0 -> Builder e classes   
0.9 -> Correções 
0.8 -> Melhorias de Desempenho
0.7 -> Correções 
0.6 -> Alterações Layout               
0.5 -> Correções              
0.4 -> Menus e Páginas             
0.3 -> BottomSheet
0.2 -> Correções
0.1 -> Inicio do Projeto

   
                            
                            
                            
                       
                            
                            
                            
                            
                        
                               
      (ಠ‿ಠ)  
      ''';

}