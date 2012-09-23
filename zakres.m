s = zeros(1,880);
m = zeros(1,880);

for i = 61:880
	s(i) = std(y(i-60:i));
	m(i) = mean(y(i-60:i));
end

min(s(61:end))
max(s(61:end))

min(m(61:end))
max(m(61:end))