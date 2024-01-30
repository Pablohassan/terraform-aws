

# Création d'un load balancer dans deux sous-réseaux publics
resource "aws_lb" "lb_datascientest" {
  name               = "datascientest-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["${aws_subnet.public_subnet_a.id}", "${aws_subnet.public_subnet_b.id}"]
  security_groups    = ["${aws_security_group.sg_application_lb.id}"]

  enable_deletion_protection = false
}

# Création d'un écouteur d'équilibrage de charge qui accepte les requêtes sur le port 80 et les redirigent à notre groupe cible
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb_datascientest.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.datascientest_vms.arn
  }
}
# Création d'un groupe cible
resource "aws_lb_target_group" "datascientest_vms" {
  name     = "tf-datascientest-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.datascientest_vpc.id
}
# Ajoutons nos serveurs Web au groupe cible:
## Joindre l' instance A à la zone de disponibilté A au groupe cible
resource "aws_lb_target_group_attachment" "datascientesta_tg_attachment" {
  target_group_arn = aws_lb_target_group.datascientest_vms.arn
  target_id        = aws_instance.datascientest_a.id

  port = 80
}

## Joindre l' instance B à la zone de disponibilté B au groupe cible
resource "aws_lb_target_group_attachment" "datascientestb_tg_attachment" {
  target_group_arn = aws_lb_target_group.datascientest_vms.arn
  target_id        = aws_instance.datascientest_b.id
  port             = 80
}

output "lb_dns_name" {
  value = aws_lb.lb_datascientest.dns_name
}