# Define ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "my-ecs-cluster"
}

# Define ECS Task Definition
resource "aws_ecs_task_definition" "app" {
  family                   = "myapp-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"


  container_definitions = jsonencode([
    {
      name      = "my-app"
      image     = "islamovna/my-nginx-image:latest" # Replace with your Docker image
      cpu       = 256
      memory    = 512
      essential = true

      portMappings : [
        {
          containerPort : 80
          hostPort : 80
        }
      ]
      command : ["nginx", "-g", "daemon off;"]
    }
  ])
}

# Define ECS Service
resource "aws_ecs_service" "my_service" {
  name            = "myapp-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name   = "my-app"
    container_port   = 80
  }

  network_configuration {
    subnets          = [aws_subnet.private_subnet[0].id] # Specify your public subnets
    security_groups  = [aws_security_group.ecs_sg.id]   # Specify the security group you created
    assign_public_ip = true
  }
  depends_on = [aws_lb_listener.my_listener, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

