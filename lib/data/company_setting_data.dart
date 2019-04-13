class CompanySetting {
  String id;
  bool isReceiveOrder;
  int costPerKM;
  int costPerKG;

  int getCost(int _distanceKM, int _weightKG) {
    return (costPerKM * _distanceKM) + (costPerKG + _weightKG);
  }
}