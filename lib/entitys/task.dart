class Task {

  int id;
  String nome;
  String nota;
  bool estado;

  Task({this.id, this.nome,this.nota,this.estado});

  int get getId{
    return id;
  }

  String get getNome{
    return nome;
  }

  String get getNota{
    return nota;
  }

}