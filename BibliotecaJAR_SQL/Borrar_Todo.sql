DROP TABLE USER_DATA CASCADE CONSTRAINTS;
DROP TABLE USER_LOGIN CASCADE CONSTRAINTS;
DROP TABLE PROV_LOGIN CASCADE CONSTRAINTS;
DROP TABLE PROV_DATA CASCADE CONSTRAINTS;
DROP TABLE ARTI_DATA CASCADE CONSTRAINTS;
DROP TABLE CATE_DATA CASCADE CONSTRAINTS;
DROP TABLE IMG_DATA CASCADE CONSTRAINTS;
DROP TABLE VENTAS CASCADE CONSTRAINTS;
DROP TABLE DETA_VENTA CASCADE CONSTRAINTS;
DROP SEQUENCE GEN_COD_ARTI;
DROP SEQUENCE GEN_COD_VENTA;
DROP PROCEDURE NEW_USER;
DROP PROCEDURE MOD_USER;
DROP PROCEDURE DEL_USER;
DROP PROCEDURE NEW_PROV;
DROP PROCEDURE DEL_PROV;
DROP PROCEDURE MOD_PROV;

COMMIT;