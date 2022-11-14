public class PokeMock implements HttpCalloutMock{
    protected Integer code;
    protected String status;
    protected String bodyAsString;
    protected Blob bodyAsBlob;
    protected Map<String, String> responseHeaders;

    public PokeMock(Integer code, String status, String body, Map<String, String> responseHeaders) {
        this.code = code;
        this.status = status;
        this.bodyAsString = body;
        this.bodyAsBlob = null;
        this.responseHeaders = responseHeaders;
    }

    public PokeMock(Integer code, String status, Blob body, Map<String, String> responseHeaders) {
        this.code = code;
        this.status = status;
        this.bodyAsBlob = body;
        this.bodyAsString = null;
        this.responseHeaders = responseHeaders;
    }  
    
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(code);
        response.setStatus(status);
        if (bodyAsBlob != null) {
            response.setBodyAsBlob(bodyAsBlob);
        } else {
            response.setBody(bodyAsString);
        }

        if (responseHeaders != null) {
             for (String key : responseHeaders.keySet()) {
                response.setHeader(key, responseHeaders.get(key));
             }
        }
        return response;
    }
}