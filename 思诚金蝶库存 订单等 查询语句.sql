use AIS20150511191520


--������ѯ
select * from SEOrder
select * from SEOrder where FBillNo like '%2651%'
select FHeadSelfS0149 from SEOrder



--��������Ϳͻ���ѯ
SELECT   a.FBillNo AS ������,a.FDate as ��������, a.FCustID AS �ͻ�id, b.FName AS �ͻ�ȫ��, a.FInvoiceName AS ��Ʊ̧ͷ, 
                a.FInvoiceReceiver AS ��Ʊ�ռ���, a.FInvoiceReceiverAddress AS ��Ʊ�ռ���ַ, 
                a.FExplanation AS ժҪ�Ϳ�ݵ����ռ�ʱ�������
FROM      dbo.SEOrder AS a INNER JOIN
                dbo.t_Organization AS b ON a.FCustID = b.FItemID 
WHERE   (a.FBillNo LIKE '%D2016%')




--��ͻ����ֺ���Դ
select * from t_Organization
select FName,F_109  from dbo.t_Organization  where FName like '%�ͻ�%' and  F_109 =40054
select a.FItemID,a.FName,b.FName,F_109  from dbo.t_Organization as a join t_SubMessage b on a.F_109=b.FInterID  
	 
--�������ϵ��ֶ�����
select * from t_SubMessage where FParentID = 501
select * from t_SubMessage where FName like '%�ͻ�%'
 where FInterID = 40054 
 
 --��ͻ���Դ�����з���        
select * from t_SubMessage 
where FParentID = 26

--�������ϵ����
select * from t_SubMesType 




--˼�� �������ѯ ��ͼ���
SELECT   dbo.t_ICItem.FModel, dbo.t_ICItem.FName AS FMaterialName, dbo.ICInventory.FQty, dbo.t_ICItem.FNumber, 
                dbo.t_MeasureUnit.FName AS FunitName
FROM      dbo.t_ICItem INNER JOIN
                dbo.ICInventory ON dbo.t_ICItem.FItemID = dbo.ICInventory.FItemID INNER JOIN
                dbo.t_MeasureUnit ON dbo.t_ICItem.FUnitID = dbo.t_MeasureUnit.FItemID
				




--��������Ϳͻ���ѯ
SELECT   a.FBillNo AS ������, a.FCustID AS �ͻ�id, b.FName AS �ͻ�ȫ��, a.FInvoiceName AS ��Ʊ̧ͷ, 
                a.FInvoiceReceiver AS ��Ʊ�ռ���, a.FInvoiceReceiverAddress AS ��Ʊ�ռ���ַ, 
                a.FExplanation AS ժҪ�Ϳ�ݵ����ռ�ʱ�������
				FROM      dbo.SEOrder AS a INNER JOIN     dbo.t_Organization AS b ON a.FCustID = b.FItemID WHERE   (a.FBillNo LIKE '%D2016%')

--��ͼkeNewCusFuZhu�Ĵ���
SELECT  a.FBillNo, CONVERT(varchar(100), a.FDate, 11) AS orderDate, a.FCustID,f.FName,FNumber, b.FName,c.FName,d.FName,e.FName
FROM      dbo.SEOrder AS a  JOIN dbo.t_Organization AS b ON a.FCustID = b.FItemID join t_SubMessage c on b.F_109=c.FInterID 
			join t_SubMessage f on b.F_110 = f.FInterID
			join t_SubMessage d on b.FRegionID = d.FInterID join t_User e on b.Femployee=e.FEmpID order by FNumber,orderDate


--�ŵ�����Ĳ�ѯ�����ġ�
select * from keNewCusFuZhu
select FCustID as �ͻ�id,min(orderDate) as ��������,gongsi as �ͻ�����,PinPai as �״ι���Ʒ��,quyu as ����,laiyuan as ��Դ,fnumber �ͻ����,yewuyuan as ҵ��Ա from keNewCusFuZhu 
 group by FCustID,gongsi,pinpai,quyu,laiyuan,fnumber,yewuyuan having min(orderDate)>'16/04/01' and min(orderDate)<'16/04/30' order by fnumber, ��������


��������������������ȷ���������䡪������������������������������������������������������������������������

/*��������Ϳͻ���ѯ��CREATE VIEW dbo.adyOrderLaiYuan */
--����Ĳ�ѯ���
SELECT   a.FBillNo, CONVERT(varchar(100), a.FDate, 11) AS orderDate, b.FName AS gongsi, c.FName AS LaiYuan, a.FCustID, 
                f.FName AS PinPai, b.FNumber
FROM      dbo.SEOrder AS a LEFT OUTER JOIN
                dbo.t_Organization AS b ON a.FCustID = b.FItemID LEFT OUTER JOIN
                dbo.t_SubMessage AS c ON b.F_109 = c.FInterID LEFT OUTER JOIN
                dbo.t_SubMessage AS f ON b.F_110 = f.FInterID

--��ѯ����������Ϳͻ���Դ
select * from adyOrderLaiYuan order by fbillno desc 

--���¶�������ͳ��
select orderDate ѯ������,gongsi ѯ�̿ͻ�����,LaiYuan �ͻ���Դ from adyOrderLaiYuan WHERE datediff(month,orderDate,getdate())=0 order by fbillno desc 

--���շ���,ͳ��ÿ�յĶ�������
select orderDate ��������, COUNT(orderdate) ���ն������� from adyOrderLaiYuan group by orderDate order by orderDate desc


--˼��seo�������ݱ���
select a.FDate ����, a.bdshoulu �ٶ���¼, a.BdQuanZhong �ٶ�Ȩ��, a.BdLiuLiang �ٶ�����, a.BdKeywords �ٶȹؼ���, a.ShouLu360 as '360��¼', a.SCsearch ˼�Ϲؼ��� FROM t_BOSseo a WHERE datediff(month,FDate,getdate())=0


