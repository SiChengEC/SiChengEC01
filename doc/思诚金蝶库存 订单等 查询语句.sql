use AIS20150511191520


--订单查询
select * from SEOrder
select * from SEOrder where FBillNo like '%2651%'
select FHeadSelfS0149 from SEOrder



--金蝶订单和客户查询
SELECT   a.FBillNo AS 订单号,a.FDate as 订单日期, a.FCustID AS 客户id, b.FName AS 客户全称, a.FInvoiceName AS 发票抬头, 
                a.FInvoiceReceiver AS 发票收件人, a.FInvoiceReceiverAddress AS 发票收件地址, 
                a.FExplanation AS 摘要和快递单号收件时间待处理
FROM      dbo.SEOrder AS a INNER JOIN
                dbo.t_Organization AS b ON a.FCustID = b.FItemID 
WHERE   (a.FBillNo LIKE '%D2016%')




--查客户名字和来源
select * from t_Organization
select FName,F_109  from dbo.t_Organization  where FName like '%客户%' and  F_109 =40054
select a.FItemID,a.FName,b.FName,F_109  from dbo.t_Organization as a join t_SubMessage b on a.F_109=b.FInterID  
	 
--辅助资料的字段名称
select * from t_SubMessage where FParentID = 501
select * from t_SubMessage where FName like '%客户%'
 where FInterID = 40054 
 
 --查客户来源的所有分类        
select * from t_SubMessage 
where FParentID = 26

--辅助资料的类别
select * from t_SubMesType 




--思诚 金蝶库存查询 视图语句
SELECT   dbo.t_ICItem.FModel, dbo.t_ICItem.FName AS FMaterialName, dbo.ICInventory.FQty, dbo.t_ICItem.FNumber, 
                dbo.t_MeasureUnit.FName AS FunitName
FROM      dbo.t_ICItem INNER JOIN
                dbo.ICInventory ON dbo.t_ICItem.FItemID = dbo.ICInventory.FItemID INNER JOIN
                dbo.t_MeasureUnit ON dbo.t_ICItem.FUnitID = dbo.t_MeasureUnit.FItemID
				




--金蝶订单和客户查询
SELECT   a.FBillNo AS 订单号, a.FCustID AS 客户id, b.FName AS 客户全称, a.FInvoiceName AS 发票抬头, 
                a.FInvoiceReceiver AS 发票收件人, a.FInvoiceReceiverAddress AS 发票收件地址, 
                a.FExplanation AS 摘要和快递单号收件时间待处理
				FROM      dbo.SEOrder AS a INNER JOIN     dbo.t_Organization AS b ON a.FCustID = b.FItemID WHERE   (a.FBillNo LIKE '%D2016%')

--视图keNewCusFuZhu的代码
SELECT  a.FBillNo, CONVERT(varchar(100), a.FDate, 11) AS orderDate, a.FCustID,f.FName,FNumber, b.FName,c.FName,d.FName,e.FName
FROM      dbo.SEOrder AS a  JOIN dbo.t_Organization AS b ON a.FCustID = b.FItemID join t_SubMessage c on b.F_109=c.FInterID 
			join t_SubMessage f on b.F_110 = f.FInterID
			join t_SubMessage d on b.FRegionID = d.FInterID join t_User e on b.Femployee=e.FEmpID order by FNumber,orderDate


--放到金蝶的查询语句里的。
select * from keNewCusFuZhu
select FCustID as 客户id,min(orderDate) as 新增日期,gongsi as 客户名称,PinPai as 首次购买品牌,quyu as 区域,laiyuan as 来源,fnumber 客户编号,yewuyuan as 业务员 from keNewCusFuZhu 
 group by FCustID,gongsi,pinpai,quyu,laiyuan,fnumber,yewuyuan having min(orderDate)>'16/04/01' and min(orderDate)<'16/04/30' order by fnumber, 新增日期


———————以下是确定无误的语句—————————————————————————————————————

/*金蝶订单和客户查询，CREATE VIEW dbo.adyOrderLaiYuan */
--具体的查询语句
SELECT   a.FBillNo, CONVERT(varchar(100), a.FDate, 11) AS orderDate, b.FName AS gongsi, c.FName AS LaiYuan, a.FCustID, 
                f.FName AS PinPai, b.FNumber
FROM      dbo.SEOrder AS a LEFT OUTER JOIN
                dbo.t_Organization AS b ON a.FCustID = b.FItemID LEFT OUTER JOIN
                dbo.t_SubMessage AS c ON b.F_109 = c.FInterID LEFT OUTER JOIN
                dbo.t_SubMessage AS f ON b.F_110 = f.FInterID

--查询结果：订单和客户来源
select * from adyOrderLaiYuan order by fbillno desc 

--本月订单数据统计
select orderDate 询盘日期,gongsi 询盘客户名称,LaiYuan 客户来源 from adyOrderLaiYuan WHERE datediff(month,orderDate,getdate())=0 order by fbillno desc 

--按日分组,统计每日的订单数量
select orderDate 订单日期, COUNT(orderdate) 当日订单数量 from adyOrderLaiYuan group by orderDate order by orderDate desc


--思诚seo本月数据报表
select a.FDate 日期, a.bdshoulu 百度收录, a.BdQuanZhong 百度权重, a.BdLiuLiang 百度流量, a.BdKeywords 百度关键词, a.ShouLu360 as '360搜录', a.SCsearch 思诚关键词 FROM t_BOSseo a WHERE datediff(month,FDate,getdate())=0


