locals {
    ami_id = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    server_name = "${local.common_tags.project}-${local.common_tags.component}-${local.common_tags.environment}"
    sg_name = "${var.project}-${var.environment}-SG"
    common_tags = {
        project = "GameApp"
        environment = "prod"
        component = "frontend"
    }

}