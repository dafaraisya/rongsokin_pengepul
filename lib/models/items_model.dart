List<String> elektronikList = [
  'Handphone',
  'Monitor LED',
  'CPU',
  'Printer',
  'Kulkas',
  'Televisi Tabung',
  'Televisi LED',
  'Aki',
  'AC',
  'Motherboard',
  'Laptop',
  'Mesin Cuci',
  'Setrika',
  'Kipas Angin',
  'Pompa Air',
];

List<String> plastikList = [
  'Botol Mineral 600 ml',
  'Botol Mineral 1.5 L',
  'Botol Plastik Berwarna',
  'Gelas Plastik',
  'Jerigen',
  'Wadah Parfum',
  'Galon',
  'Pipa Paralon',
];

List<String> kertasList = [
  'Karton',
  'Kardus',
  'Buku',
  'Kanvas',
];

List<String> kacaList = [
  'Cermin',
  'Kaca Bening',
  'Botol Kaca',
];

List<String> logamList = [
  'Kaleng',
  'Peralatan Masak',
  'Tembaga',
  'Kuningan',
  'Aluminium',
  'Radiator',
];

List<String> kainList = [
    'Kain Perca',
    'Sepatu',
    'Tas',
];

class ItemsModel {
  String category;
  String itemName;
  String description;
  int price;
  int weight;

  ItemsModel({
    required this.category,
    required this.itemName,
    required this.description,
    required this.price,
    required this.weight,
  });
}

int setPrice(String key) {
  switch (key) {
    case 'Handphone':
      return 5000;
    case 'Monitor LED':
      return 20000;
    case 'CPU':
      return 20000;
    case 'Printer':
      return 15000;
    case 'Kulkas':
      return 60000;
    case 'Televisi Tabung':
      return 15000;
    case 'Televisi LED':
      return 30000;
    case 'Aki':
      return 10000;
    case 'AC':
      return 100000;
    case 'Motherboard':
      return 10000;
    case 'Laptop':
      return 20000;
    case 'Mesin Cuci':
      return 50000;
    case 'Setrika':
      return 15000;
    case 'Kipas Angin':
      return 10000;
    case 'Pompa Air':
      return 20000;
    case 'Botol Mineral 600 ml':
      return 1000;
    case 'Botol Mineral 1.5 L':
      return 1500;
    case 'Botol Plastik Berwarna':
      return 2000;
    case 'Gelas Plastik':
      return 250;
    case 'Jerigen':
      return 500;
    case 'Wadah Parfum':
      return 1200;
    case 'Galon':
      return 10000;
    case 'Pipa Paralon':
      return 1000;
    case 'Karton':
      return 500;
    case 'Kardus':
      return 1000;
    case 'Buku':
      return 700;
    case 'Kanvas':
      return 2000;
    case 'Cermin':
      return 500;
    case 'Kaca Bening':
      return 300;
    case 'Botol Kaca':
      return 200;
    case 'Kaleng':
      return 800;
    case 'Peralatan Masak':
      return 500;
    case 'Tembaga':
      return 70000;
    case 'Kuningan':
      return 50000;
    case 'Aluminium':
      return 12000;
    case 'Radiator':
      return 250000;
    case 'Kain Perca':
      return 2000;
    case 'Sepatu':
      return 15000;
    case 'Tas':
      return 20000;
    default:
      return 0;
  }
}

String getCategory(String key) {
  switch (key) {
    case 'Handphone':
      return 'Elektronik';
    case 'Monitor LED':
      return 'Elektronik';
    case 'CPU':
      return 'Elektronik';
    case 'Printer':
      return 'Elektronik';
    case 'Kulkas':
      return 'Elektronik';
    case 'Televisi Tabung':
      return 'Elektronik';
    case 'Televisi LED':
      return 'Elektronik';
    case 'Aki':
      return 'Elektronik';
    case 'AC':
      return 'Elektronik';
    case 'Motherboard':
      return 'Elektronik';
    case 'Laptop':
      return 'Elektronik';
    case 'Mesin Cuci':
      return 'Elektronik';
    case 'Setrika':
      return 'Elektronik';
    case 'Kipas Angin':
      return 'Elektronik';
    case 'Pompa Air':
      return 'Elektronik';
    case 'Botol Mineral 600 ml':
      return 'Plastik';
    case 'Botol Mineral 1.5 L':
      return 'Plastik';
    case 'Botol Plastik Berwarna':
      return 'Plastik';
    case 'Gelas Plastik':
      return 'Plastik';
    case 'Jerigen':
      return 'Plastik';
    case 'Wadah Parfum':
      return 'Plastik';
    case 'Galon':
      return 'Plastik';
    case 'Pipa Paralon':
      return 'Plastik';
    case 'Karton':
      return 'Kertas';
    case 'Kardus':
      return 'Kertas';
    case 'Buku':
      return 'Kertas';
    case 'Kanvas':
      return 'Kertas';
    case 'Cermin':
      return 'Kaca';
    case 'Kaca Bening':
      return 'Kaca';
    case 'Botol Kaca':
      return 'Kaca';
    case 'Kaleng':
      return 'Logam';
    case 'Peralatan Masak':
      return 'Logam';
    case 'Tembaga':
      return 'Logam';
    case 'Kuningan':
      return 'Logam';
    case 'Aluminium':
      return 'Logam';
    case 'Radiator':
      return 'Logam';
    case 'Kain Perca':
      return 'Kain';
    case 'Sepatu':
      return 'Kain';
    case 'Tas':
      return 'Kain';
    default:
      return 'Error';
  }
}
