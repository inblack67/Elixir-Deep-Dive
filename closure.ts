const say = () => {
  const ok = 10;
  const something = () => {
    console.log(ok);
  };
  return something;
};

const res = say();
res();
