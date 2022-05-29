# Dependencies

-   GNU Image Manipulator (GIMP)
-   python

# Run

```bash
./main [-s <csv/filename.csv>] [-c <indices>] [-t <template>]
```

-   csv/filename.csv - path to CSV file. Maybe stored in `csv/` dir
-   indices (e.g. default: `0+1,2`) - indices of columns in CSV to pass to template. Use `+` to join columns (e.g. `1+2,3` (e.g. Name+Surname,Country))
-   template on of `./templates`
-   scheme on of `./schemes` without extension
