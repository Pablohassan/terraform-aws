resource "aws_security_group" "sg_22" {

  name   = "sg_22"
  vpc_id = aws_vpc.datascientest_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg-22"
  }
}
resource "aws_security_group" "sg_datascientest" {
  name   = "sg_datascientest"
  vpc_id = aws_vpc.datascientest_vpc.id
  tags = {
    type = "sg_datascientest"
  }
}

resource "aws_security_group_rule" "allow_all" {
  type              = "ingress"
  cidr_blocks       = ["10.1.0.0/24"]
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_datascientest.id
}
## Création de serveurs datascientest pour le sous-réseau d'application A  groupe de sécurité pour autoriser le trafic vers les instances EC2.
resource "aws_security_group_rule" "outbound_allow_all" {
  type = "egress"

  cidr_blocks       = ["0.0.0.0/0"]
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_datascientest.id
}


## Création d'un équilibreur de charge d'application pour accéder à l'application
resource "aws_security_group" "sg_application_lb" {

  name   = "sg_application_lb"
  vpc_id = aws_vpc.datascientest_vpc.id
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # Veuillez limiter votre entrée aux seules adresses IP et ports nécessaires.
    # L'ouverture à 0.0.0.0/0 peut entraîner des failles de sécurité.
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Datascientest-alb"
  }

}