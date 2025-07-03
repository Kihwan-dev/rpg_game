abstract class Unit {
  String name;
  int hp;
  int ap;
  int dp;

  Unit(this.name, this.hp, this.ap, this.dp);

  void showStatus();
  
  void attack(covariant Unit target);
  
}