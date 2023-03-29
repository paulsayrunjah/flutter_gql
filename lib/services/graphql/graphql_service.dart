import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';
import 'package:test_gql/services/api/errors/network_call_error.dart';

@Singleton()
class GraphQLService {
  GraphQLClient client() {
    final link = HttpLink(
      'http://192.168.0.102:8080',
    );

    return GraphQLClient(link: link, cache: GraphQLCache());
  }

  Map<String, dynamic> processResult(QueryResult result) {
    final data = result.data;
    if (data == null) {
      throw CustomApiException('Invalid data for query result');
    }

    return data;
  }
}
