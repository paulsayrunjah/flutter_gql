const String mutationAddPerson = r'''
  mutation AddPerson($name: String) {
    addPerson(name: $name) {
      name
    }
  }
''';
