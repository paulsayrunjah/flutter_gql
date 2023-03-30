import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';
import 'package:test_gql/app/locator.dart';
import 'package:test_gql/models/person.dart';
import 'package:test_gql/services/api/errors/network_call_error.dart';
import 'package:test_gql/services/api/user/mutations.dart';
import 'package:test_gql/services/api/user/queries.dart';
import 'package:test_gql/services/api/user/request_models/add_person_request.dart';
import 'package:test_gql/services/api/user/response_models/add_person_response.dart';
import 'package:test_gql/services/api/user/response_models/people_response.dart';
import 'package:test_gql/services/graphql/graphql_service.dart';
import "package:http/http.dart" show MultipartFile;
import "package:http_parser/http_parser.dart" show MediaType;

@LazySingleton()
class UserApi {
  final graphQlService = locator<GraphQLService>();

  Future<List<Person>?> getPeople() async {
    final graphQlClient = graphQlService.client();

    final QueryOptions options = QueryOptions(document: gql(queryGetPeople));

    final QueryResult result = await graphQlClient.query(options);
    if (result.hasException) {
      throw graphQlService.handleException(result.exception!);
    }

    try {
      final data = graphQlService.processResult(result);
      return PeopleResponse.fromJson(data).people;
    } catch (e) {
      throw DataParsingException();
    }
  }

  Future<Person?> addPerson(final AddPersonRequest request) async {
    final graphQlClient = graphQlService.client();

    final MutationOptions options = MutationOptions(
      document: gql(mutationAddPerson),
      variables: <String, dynamic>{
        'name': request.name,
      },
    );

    final QueryResult result = await graphQlClient.mutate(options);
    if (result.hasException) {
      throw CustomApiException(result.exception.toString());
    }

    try {
      final data = graphQlService.processResult(result);
      return AddPersonResponse.fromJson(data).person;
    } catch (e) {
      throw DataParsingException();
    }
  }

  Future<bool?> addPersonImage(final file) async {
    final graphQlClient = graphQlService.client();

    final myFile = MultipartFile.fromString(
      "",
      "just plain text",
      filename: "sample_upload.txt",
      contentType: MediaType("text", "plain"),
    );

    final MutationOptions options = MutationOptions(
      document: gql(mutationAddImage),
      variables: <String, dynamic>{
        'file': file,
        'person': '642369e846dd117c2e537db6'
      },
    );

    final QueryResult result = await graphQlClient.mutate(options);
    print(result);
    if (result.hasException) {
      throw CustomApiException(result.exception.toString());
    }

    try {
      final data = graphQlService.processResult(result);
      return true;
    } catch (e) {
      throw DataParsingException();
    }
  }
}
