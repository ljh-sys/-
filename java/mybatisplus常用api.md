# MybatisPlus 常用 API

## 插入操作

将实体类对象插入到数据库中: `save(实体类)`

## 条件查询

根据字段名查询:

```java
User user = lambdaquery
    .eq(字段名, 值)
    .like(判断字段名不能为空, 字段名, 值)
    .one();
```

## 条件更新

```java
lambdaupdate()
    .eq("id", id)
    .set(字段名, 值)
    .update();
```

## 分页查询

```java
public PageResult pageQuery(EmployeePageQueryDTO employeePageQueryDTO) {
    //select * from employeePage limit 0,10
    //配置分页条件
    Page page = Page.of(employeePageQueryDTO.getPage(), employeePageQueryDTO.getPageSize());
    //设置排序时间
    page.addOrder(new OrderItem("createTime", true));
    //分页查询
    Page p = lambdaQuery()
            //添加模糊查询条件
            .like(StrUtil.isNotBlank(employeePageQueryDTO.getName()), Employee::getName, employeePageQueryTDO.getName())
            .page(page);
    long total = p.getTotal();
    List<Employee> employees = p.getRecords();
    return new PageResult(total, employees);
}
```

## 联表分页查询

### service 层

```java
public PageResult pageQuery(DishPageQueryDTO dishPageQueryDTO) {
    IPage<DishVO> page = new Page(dishPageQueryDTO.getPage(), dishPageQueryDTO.getPageSize());
    QueryWrapper<DishVO> wrapper = new QueryWrapper<>();
    wrapper
            .like(StrUtil.isNotBlank(dishPageQueryDTO.getName()), "name", dishPageQueryDTO.getName())
            .orderByDesc("create_time");
    IPage<DishVO> p = dishMapper.pageList(page, wrapper);
    long total = p.getTotal();
    List<DishVO> dishVO = p.getRecords();
    return new PageResult(total, dishVO);
}
```

### mapper 层

```java
@Select("select d.*,c.name as categoryName from dish d left outer join category c on d.category_id = c.id"
        + "${ew.customSqlSegment}")//将where条件拼接发到这里
Page<DishVO> pageList(IPage<DishVO> page, @Param(Constants.WRAPPER) QueryWrapper<DishVO> wrapper);
```
