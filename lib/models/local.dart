class Local {
  String id;
  double temperatura;
  String date_time;
  String activity;
  bool status; //Status da atividade (true = feita, false = to do)

  //Construtor
  Local({
    this.id,
    this.temperatura,
    this.date_time,
    this.activity,
    this.status,
  });
}
