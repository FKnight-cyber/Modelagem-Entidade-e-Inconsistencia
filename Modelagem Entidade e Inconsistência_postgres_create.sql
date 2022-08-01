CREATE TABLE "public.users" (
	"id" serial NOT NULL,
	"name" varchar(50) NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	CONSTRAINT "users_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.products" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	"price" double NOT NULL,
	"mainImageId" int NOT NULL,
	"categoryId" int NOT NULL,
	"measureId" int NOT NULL,
	"subImageId" int NOT NULL,
	CONSTRAINT "products_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.categories" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	CONSTRAINT "categories_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TYPE measure AS ENUM ('P', 'M', 'G');
CREATE TABLE "public.measures" (
	"id" serial NOT NULL,
	"size" measure,
	CONSTRAINT "measures_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.purchases" (
	"id" serial NOT NULL,
	"productId" int NOT NULL,
	"quantity" int NOT NULL,
	"price" double NOT NULL,
	"statusId" int NOT NULL,
	"deliveryAddressId" int NOT NULL,
	"purchaseTime" DATE NOT NULL,
	"userId" int NOT NULL,
	CONSTRAINT "purchases_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TYPE status AS ENUM ('Criada', 'Paga', 'Entregue','Cancelada');
CREATE TABLE "public.purchaseStatus" (
	"id" serial NOT NULL,
	"current_status" status,
	CONSTRAINT "purchaseStatus_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.mainImage" (
	"id" serial NOT NULL,
	"image" TEXT NOT NULL,
	CONSTRAINT "mainImage_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.subImage" (
	"id" serial NOT NULL,
	"image" TEXT,
	CONSTRAINT "subImage_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.deliveryAddress" (
	"id" serial NOT NULL,
	"address" TEXT NOT NULL,
	"userId" int NOT NULL,
	CONSTRAINT "deliveryAddress_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

ALTER TABLE "products" ADD CONSTRAINT "products_fk0" FOREIGN KEY ("mainImageId") REFERENCES "mainImage"("id");
ALTER TABLE "products" ADD CONSTRAINT "products_fk1" FOREIGN KEY ("categoryId") REFERENCES "categories"("id");
ALTER TABLE "products" ADD CONSTRAINT "products_fk2" FOREIGN KEY ("measureId") REFERENCES "measures"("id");
ALTER TABLE "products" ADD CONSTRAINT "products_fk3" FOREIGN KEY ("subImageId") REFERENCES "subImage"("id");
ALTER TABLE "purchases" ADD CONSTRAINT "purchases_fk0" FOREIGN KEY ("productId") REFERENCES "products"("id");
ALTER TABLE "purchases" ADD CONSTRAINT "purchases_fk1" FOREIGN KEY ("statusId") REFERENCES "purchaseStatus"("id");
ALTER TABLE "purchases" ADD CONSTRAINT "purchases_fk2" FOREIGN KEY ("deliveryAddressId") REFERENCES "deliveryAddress"("id");
ALTER TABLE "purchases" ADD CONSTRAINT "purchases_fk3" FOREIGN KEY ("userId") REFERENCES "users"("id");
ALTER TABLE "deliveryAddress" ADD CONSTRAINT "deliveryAddress_fk0" FOREIGN KEY ("userId") REFERENCES "users"("id");
