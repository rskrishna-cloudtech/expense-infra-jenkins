# Resource to create a parameter to store the arn of the web alb listener for HTTP.
resource "aws_ssm_parameter" "web_alb_listener_arn" {
  name  = "/${var.project_name}/${var.environment}/web_alb_listener_arn"
  type  = "String"
  value = aws_lb_listener.http.arn
}

# Resource to create a parameter to store the arn of the web alb listener for HTTPS.
resource "aws_ssm_parameter" "web_alb_listener_arn_https" {
  name  = "/${var.project_name}/${var.environment}/web_alb_listener_arn_https"
  type  = "String"
  value = aws_lb_listener.https.arn
}

