# enum

## enum 的使用场景

enum 枚举常被用来为各种标志位设置语义提示，比如：

当后端返回的 json 数据中有一个字段 status，
该字段通过不同的整数取值表示不同的状态时，
便可考虑使用 enum 来为这些取值设置语义：

```typescript
enum Status {
  // 为任意元素设置初始值后，ts会自动为后续元素设置递增后的值
  todo = 0,
  done,
  archived,
  deleted,
}

interface R {
  name: string;
  status: Status;
}

let file: R = {
  name: 'temp',
  status: Status.archived,
};

console.log(file.status);   // 2
```

此外，enum 也可以用作前端的权限控制

```typescript
enum Permission {
  None = 0, // 0000
  Read = 1 << 0, // 0001
  Write = 1 << 1, // 0010
  Delete = 1 << 2, // 0100
  Manage = Read | Write | Delete, // 0111
}

type User = {
  permission: Permission;
};

const user = {
  // 0b 代表二进制
  permission: 0b0111,
};

// 权限判断
if (canWrite(user.permission)) {
  console.log('用户具有写权限');
}
if (canManage(user.permission)) {
  console.log('用户具有管理权限');
}

function canWrite(permission: Permission): boolean {
  return (permission & Permission.Write) === Permission.Write;
}

function canManage(permission: Permission): boolean {
  return (user.permission & Permission.Manage) === Permission.Manage;
}
```

## 不应使用 enum 的情况

当选项本身边存在语义的时候不应使用 enum，而应该直接使用 type 定义集合

```typescript
enum Fruit {
  apple = 'apple',
  banana = 'banana',
  pineapple = 'pineapple',
  watermelon = 'watermelon',
}

let f: Fruit = Fruit.apple;
f = Fruit.watermelon;
console.log(f);
```

以上例子中，因为 Fruit 中的选项所代表的值本身就有便于理解的完整语义，
因此再使用 enum 就会显得多此一举

由于 typescript 的数据类型本质上是一种值的集合，
所以上述代码可以直接改成以下形式:
