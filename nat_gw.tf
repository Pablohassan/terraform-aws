## Créer une passerelle nat pourle sous-réseau public a et une ip élastique
resource "aws_eip" "eip_public_a" {
    domain = "vpc"
}
resource "aws_nat_gateway" "gw_public_a" {
  allocation_id = aws_eip.eip_public_a.id
  subnet_id     = aws_subnet.public_subnet_a.id

  tags = {
    Name = "datascientest-nat-public-a"
  }
}
##################################################### FIN

resource "aws_eip" "eip_public_b" {
  domain = "vpc"
}
resource "aws_nat_gateway" "gw_public_b" {
  allocation_id = aws_eip.eip_public_b.id
  subnet_id     = aws_subnet.public_subnet_b.id

  tags = {
    Name = "datascientest-nat-public-b"
  }
}