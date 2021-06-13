// locals {
//  vpc_name = "${var.environment}-vpc"
//  igw_name = "${var.environment}-igw"
//  private_subnet_name = "${var.environment}-${element(var.availability_zones, count.index)}-private-subnet"
//  public_subnet_name = "${var.environment}-${element(var.availability_zones, count.index)}-public-subnet"
//  private_route_table_name = "${var.environment}-private-route-table"
//  public_route_table_name = "${var.environment}-public-route-table"
//  default_sg_name = "${var.environment}-default-sg"
// }