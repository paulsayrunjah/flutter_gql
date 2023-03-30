const String mutationAddPerson = r'''
  mutation AddPerson($name: String) {
    addPerson(name: $name) {
      name
    }
  }
''';

const String mutationAddImage = r'''
  mutation addPersonImage($person: String, $file: Upload){
  addPersonImage(person: $person, file: $file)
}
 ''';
