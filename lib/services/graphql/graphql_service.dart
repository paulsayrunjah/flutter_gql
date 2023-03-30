import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';
import 'package:test_gql/services/api/errors/network_call_error.dart'
    as NetworkErrors;
import 'package:test_gql/util/constants.dart';

@Singleton()
class GraphQLService {
  GraphQLClient client() {
    final link = HttpLink(
      '$baseUrl/graphql',
    );

    return GraphQLClient(link: link, cache: GraphQLCache());
  }

  Map<String, dynamic> processResult(QueryResult result) {
    final data = result.data;
    if (data == null) {
      throw NetworkErrors.CustomApiException('Invalid data for query result');
    }

    return data;
  }

  Exception handleException(OperationException operationException) {
    if (operationException.linkException is ServerException ||
        operationException.linkException is NetworkException) {
      return NetworkErrors.ServerException();
    }

    if (operationException.graphqlErrors.isNotEmpty) {
      final error = operationException.graphqlErrors.first.message;
      return NetworkErrors.CustomApiException(error);
    }

    return NetworkErrors.CustomApiException('Internal server error');
  }
}
