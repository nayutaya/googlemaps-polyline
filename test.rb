
# 実データによるデコードのテスト

require "polyline"

polyline = "ocneEksi|WlGaBzQaEhI}A|MoB~PeBzNy@xHUrUKl|@|CbNbA`J|@pCb@dM~BjPnEdOxFjJpEpHjEtGfEd{@nl@~DfCnH|DlYfMhSfGhI~AfOpBnOfAtOTjQ]hPsAxKwAfFaAd]_IfUyG`_AyUlIqAjKmCrV{ErMsBpVmClWmA`[EpVv@v[tCv_@tGtQzE`WtI|UxKvMdIpKtH|NnLfKpJnx@n{@lGvFpJhJvRjRjK~K`FnEf{AldBvgAdlA`SzTleAriA`Yb[~b@vd@hIdJ|IdJpIxJ~OjPzBrBnGvHxSzTxHvHpEtFnRfTh]z^lIbKhIzLfJnPrE`KtK~Xr_@fnAdv@hiChDfKrL`XjIhM`FzGvNzPdFfFpJnI`NhK~R|O`c@t`@bFlFpNbQzm@by@"
level    = "B???@??@????A???@???@?@???A???@?????@???A??@?@?A???@?????@?????????????????A???@?@?A???@????@?B"

points = GoogleMapsEncodedPolyline.decode_polyline(StringIO.new(polyline))
levels = GoogleMapsEncodedPolyline.decode_levels(StringIO.new(level))

points.zip(levels).each { |point, level|
  p [point, level]
}
