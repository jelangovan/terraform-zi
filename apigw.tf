resource "aws_api_gateway_rest_api" "zoominfo-api" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "example"
      version = "1.0"
    }
    paths = {
      "/test" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://zoominfo-public-alb-143402913.eu-west-1.elb.amazonaws.com/test"
          }
        }
      }
    }
  })

  name = "zoominfo-api"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "zoominfo-api" {
  rest_api_id = aws_api_gateway_rest_api.zoominfo-api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.zoominfo-api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "zoominfo-api" {
  deployment_id = aws_api_gateway_deployment.zoominfo-api.id
  rest_api_id   = aws_api_gateway_rest_api.zoominfo-api.id
  stage_name    = "dev"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = "${aws_api_gateway_rest_api.zoominfo-api.id}"
  parent_id   = "${aws_api_gateway_rest_api.zoominfo-api.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = "${aws_api_gateway_rest_api.zoominfo-api.id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = "${aws_api_gateway_rest_api.zoominfo-api.id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.method.http_method}"
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "http://zoominfo-public-alb-143402913.eu-west-1.elb.amazonaws.com/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
  
}
