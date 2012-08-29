#import "Kiwi.h"
#import "LSStubRequest.h"
#import "LSHTTPRequestDSLRepresentation.h"

SPEC_BEGIN(LSHTTPRequestDSLRepresentationSpec)
describe(@"description", ^{
    __block LSHTTPRequestDSLRepresentation *dsl = nil;
    describe(@"a request with a GET method and url", ^{
        beforeEach(^{
            LSStubRequest *request = [[LSStubRequest alloc] initWithMethod:@"GET" url:@"http://www.google.com"];
            dsl = [[LSHTTPRequestDSLRepresentation alloc] initWithRequest:request];
        });
        it(@"should return the DSL representation", ^{
            [[[dsl description] should] equal:@"stubRequest(@\"GET\", @\"http://www.google.com\");"];
        });
    });
    describe(@"a request with a POST method and a url", ^{
        beforeEach(^{
            LSStubRequest *request = [[LSStubRequest alloc] initWithMethod:@"POST" url:@"http://luissolano.com"];
            dsl = [[LSHTTPRequestDSLRepresentation alloc] initWithRequest:request];

        });
        it(@"should return the DSL representation", ^{
            [[[dsl description] should] equal:@"stubRequest(@\"POST\", @\"http://luissolano.com\");"];
        });
    });
    describe(@"a request with one header", ^{
        beforeEach(^{
            LSStubRequest *request = [[LSStubRequest alloc] initWithMethod:@"POST" url:@"http://luissolano.com"];
            [request setHeader:@"Accept" value:@"text/plain"];
            dsl = [[LSHTTPRequestDSLRepresentation alloc] initWithRequest:request];
        });
        it(@"should return the DSL representation", ^{
            [[[dsl description] should] equal:@"stubRequest(@\"POST\", @\"http://luissolano.com\").\nwithHeaders(@{ @\"Accept\": @\"text/plain\" });"];
        });
    });
    describe(@"a request with 3 headers", ^{
        beforeEach(^{
            LSStubRequest *request = [[LSStubRequest alloc] initWithMethod:@"POST" url:@"http://luissolano.com"];
            [request setHeader:@"Accept" value:@"text/plain"];
            [request setHeader:@"Content-Length" value:@"18"];
            [request setHeader:@"If-Match" value:@"a8fhw0dhasd03qn02"];
            dsl = [[LSHTTPRequestDSLRepresentation alloc] initWithRequest:request];
            
        });
        it(@"should return the DSL representation", ^{
            NSString *expected = @"stubRequest(@\"POST\", @\"http://luissolano.com\").\nwithHeaders(@{ @\"Accept\": @\"text/plain\", @\"Content-Length\": @\"18\", @\"If-Match\": @\"a8fhw0dhasd03qn02\" });";
            [[[dsl description] should] equal:expected];
        });
    });
    describe(@"a request with headers and body", ^{
        beforeEach(^{
            LSStubRequest *request = [[LSStubRequest alloc] initWithMethod:@"POST" url:@"http://luissolano.com"];
            [request setHeader:@"Accept" value:@"text/plain"];
            [request setHeader:@"Content-Length" value:@"18"];
            [request setHeader:@"If-Match" value:@"a8fhw0dhasd03qn02"];
            [request setBody:[@"The body of a request, yeah!" dataUsingEncoding:NSUTF8StringEncoding]];
            dsl = [[LSHTTPRequestDSLRepresentation alloc] initWithRequest:request];
            
        });
        it(@"should return the DSL representation", ^{
            NSString *expected = @"stubRequest(@\"POST\", @\"http://luissolano.com\").\nwithHeaders(@{ @\"Accept\": @\"text/plain\", @\"Content-Length\": @\"18\", @\"If-Match\": @\"a8fhw0dhasd03qn02\" }).\nwithBody(@\"The body of a request, yeah!\");";
            [[[dsl description] should] equal:expected];
        });
    });
});
SPEC_END